// Copyright 2019 The MathWorks, Inc.

#include "network/websocket/client.h"
#include <iostream>

std::vector<std::shared_ptr<emscripten::val>> Network::WebSocket::Client::clientPtrs_;
std::mutex Network::WebSocket::Client::mu_;

auto Network::WebSocket::Client::url(emscripten::val client) -> std::string
{
    return client["url"].as<std::string>();
};

Network::WebSocket::Client::Client(const std::string url)
{
    std::lock_guard<std::mutex> lock(mu_);

    std::cout << "Number of sockets: " << clientPtrs_.size() << std::endl;

    // Check if client already exists in the list
    auto urlMatch = [&url](std::shared_ptr<emscripten::val> client) {
        std::cout << (*client.get())["url"].as<std::string>() << std::endl;
        return url.compare((*client.get())["url"].as<std::string>()) == 0;
    };

    
    auto it = std::find_if(clientPtrs_.begin(), clientPtrs_.end(), urlMatch);

    if (it != this->clientPtrs_.end())
    {
        this->clientPtr_ = *it;
        std::cout << "Using existing websocket." << std::endl;
        return;
    }

    // Otherwise create a new client object
    this->clientPtr_ = std::make_shared<emscripten::val>(emscripten::val::global("WebSocket").new_(emscripten::val(url)));
    this->clientPtrs_.push_back(this->clientPtr_);
    std::cout << "Creating new websocket." << std::endl;
    return;
};

auto Network::WebSocket::Client::url(void) -> std::string
{
    return (*clientPtr_.get())["url"].as<std::string>();
};

auto Network::WebSocket::Client::send(const std::string message) -> void
{
    (*clientPtr_.get()).call<void>("send", emscripten::val(message));
};

auto Network::WebSocket::Client::close(void) -> void
{
    (*clientPtr_.get()).call<void>("close");
};

auto Network::WebSocket::Client::readyState(void) -> int
{
    return (*clientPtr_.get())["readyState"].as<int>();
};

auto Network::WebSocket::Client::remove(const std::string url) -> void
{
    std::lock_guard<std::mutex> lock(mu_);

    // Check if client already exists in the list
    auto urlMatch = [&url](std::shared_ptr<emscripten::val> client) {
        return url.compare((*client.get())["url"].as<std::string>()) == 0;
    };

    auto it = std::find_if(clientPtrs_.begin(), clientPtrs_.end(), urlMatch);

    if (it == clientPtrs_.end())
        return;

    if ((*(it->get()))["readyState"].as<int>() != ReadyStatus::CLOSED)
        return;

    if (it->use_count() > 1)
        return;

    clientPtrs_.erase(it);
};

/* Callback */
auto Network::WebSocket::Client::addEventListener(const std::string eventName, const std::string callbackFcnName) -> void
{
    const emscripten::val callbackWrapperFcn = emscripten::val::global("Module")[callbackFcnName];
    (*clientPtr_.get()).call<void>("addEventListener", emscripten::val(eventName), callbackWrapperFcn);
    return;
};

auto Network::WebSocket::Client::removeEventListener(const std::string eventName, const std::string callbackFcnName) -> void
{
    const emscripten::val callbackWrapperFcn = emscripten::val::global("Module")[callbackFcnName];
    (*clientPtr_.get()).call<void>("removeEventListener", emscripten::val(eventName), callbackWrapperFcn);
    return;
};